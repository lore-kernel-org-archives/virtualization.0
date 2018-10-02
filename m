From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] VMCI: Resource wildcard match fixed
Date: Tue, 2 Oct 2018 15:35:02 -0700
Message-ID: <20181002223502.GA31116__18713.0020036877$1538519581$gmane$org@kroah.com>
References: <20180921073105.5758-1-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180921073105.5758-1-jhansen@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jorgen Hansen <jhansen@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 21, 2018 at 12:31:05AM -0700, Jorgen Hansen wrote:
> When adding a VMCI resource, the check for an existing entry
> would ignore that the new entry could be a wildcard. This could
> result in multiple resource entries that would match a given
> handle. One disastrous outcome of this is that the
> refcounting used to ensure that delayed callbacks for VMCI
> datagrams have run before the datagram is destroyed can be
> wrong, since the refcount could be increased on the duplicate
> entry. This in turn leads to a use after free bug. This issue
> was discovered by Hangbin Liu using KASAN and syzkaller.
> 
> Fixes: bc63dedb7d46 ("VMCI: resource object implementation")
> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_driver.c   | 2 +-
>  drivers/misc/vmw_vmci/vmci_resource.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
> index d7eaf1eb11e7..003bfba40758 100644
> --- a/drivers/misc/vmw_vmci/vmci_driver.c
> +++ b/drivers/misc/vmw_vmci/vmci_driver.c
> @@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
>  
>  MODULE_AUTHOR("VMware, Inc.");
>  MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
> -MODULE_VERSION("1.1.5.0-k");
> +MODULE_VERSION("1.1.6.0-k");
>  MODULE_LICENSE("GPL v2");

You do know MODULE_VERSION means nothing, right?  Please just remove it.

thanks,

greg k-h
