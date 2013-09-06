From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3 1/7] Intel MIC Host Driver for X100 family.
Date: Thu, 5 Sep 2013 21:55:03 -0700
Message-ID: <20130906045503.GB28806@kroah.com>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
	<8b972a444f4529ecffc718db4112aa8959bf72ad.1378423596.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8b972a444f4529ecffc718db4112aa8959bf72ad.1378423596.git.sudeep.dutt@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Very minor nits, you can change this in a future add-on patch:

> +static DEVICE_ATTR(family, S_IRUGO, mic_show_family, NULL);

This should use DEVICE_ATTR_RO(), so that we don't have to audit the
permissions of your DEVICE_ATTR() files.

> +static DEVICE_ATTR(stepping, S_IRUGO, mic_show_stepping, NULL);

Same here.

> +static struct attribute *mic_default_attrs[] = {
> +	&dev_attr_family.attr,
> +	&dev_attr_stepping.attr,
> +
> +	NULL
> +};
> +
> +static struct attribute_group mic_attr_group = {
> +	.attrs = mic_default_attrs,
> +};
> +
> +static const struct attribute_group *__mic_attr_group[] = {
> +	&mic_attr_group,
> +	NULL
> +};

These last two structures can be replaced with:
ATTRIBUTE_GROUPS(mic_default);

> +void mic_sysfs_init(struct mic_device *mdev)
> +{
> +	mdev->attr_group = __mic_attr_group;
> +}

This is "odd", why not just export the data structure and reference it
in the other code?  The pci core does this, and so do other busses.

Anyway, it's not a big deal, just a bit strange to me.

thanks,

greg k-h
