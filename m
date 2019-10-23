From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V5 2/6] modpost: add support for mdev class id
Date: Wed, 23 Oct 2019 15:42:45 -0600
Message-ID: <20191023154245.32e4fa49__32131.1008463212$1571867017$gmane$org@x1.home>
References: <20191023130752.18980-1-jasowang@redhat.com>
	<20191023130752.18980-3-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023130752.18980-3-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 23 Oct 2019 21:07:48 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Add support to parse mdev class id table.
> 
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vfio/mdev/vfio_mdev.c     |  2 ++
>  scripts/mod/devicetable-offsets.c |  3 +++
>  scripts/mod/file2alias.c          | 10 ++++++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.c
> index 7b24ee9cb8dd..cb701cd646f0 100644
> --- a/drivers/vfio/mdev/vfio_mdev.c
> +++ b/drivers/vfio/mdev/vfio_mdev.c
> @@ -125,6 +125,8 @@ static const struct mdev_class_id id_table[] = {
>  	{ 0 },
>  };
>  
> +MODULE_DEVICE_TABLE(mdev, id_table);
> +

Two questions, first we have:

#define MODULE_DEVICE_TABLE(type, name)                                 \
extern typeof(name) __mod_##type##__##name##_device_table               \
  __attribute__ ((unused, alias(__stringify(name))))

Therefore we're defining __mod_mdev__id_table_device_table with alias
id_table.  When the virtio mdev bus driver is added in 5/6 it uses the
same name value.  I see virtio types all register this way (virtio,
id_table), so I assume there's no conflict, but pci types mostly (not
entirely) seem to use unique names.  Is there a preference to one way
or the other or it simply doesn't matter?

>  static struct mdev_driver vfio_mdev_driver = {
>  	.name	= "vfio_mdev",
>  	.probe	= vfio_mdev_probe,
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 054405b90ba4..6cbb1062488a 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -231,5 +231,8 @@ int main(void)
>  	DEVID(wmi_device_id);
>  	DEVID_FIELD(wmi_device_id, guid_string);
>  
> +	DEVID(mdev_class_id);
> +	DEVID_FIELD(mdev_class_id, id);
> +
>  	return 0;
>  }
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index c91eba751804..d365dfe7c718 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1335,6 +1335,15 @@ static int do_wmi_entry(const char *filename, void *symval, char *alias)
>  	return 1;
>  }
>  
> +/* looks like: "mdev:cN" */
> +static int do_mdev_entry(const char *filename, void *symval, char *alias)
> +{
> +	DEF_FIELD(symval, mdev_class_id, id);
> +
> +	sprintf(alias, "mdev:c%02X", id);

A lot of entries call add_wildcard() here, should we?  Sorry for the
basic questions, I haven't played in this code.  Thanks,

Alex

> +	return 1;
> +}
> +
>  /* Does namelen bytes of name exactly match the symbol? */
>  static bool sym_is(const char *name, unsigned namelen, const char *symbol)
>  {
> @@ -1407,6 +1416,7 @@ static const struct devtable devtable[] = {
>  	{"typec", SIZE_typec_device_id, do_typec_entry},
>  	{"tee", SIZE_tee_client_device_id, do_tee_entry},
>  	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
> +	{"mdev", SIZE_mdev_class_id, do_mdev_entry},
>  };
>  
>  /* Create MODULE_ALIAS() statements.
