From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: Disable CONFIG_S390_GUEST_OLD_TRANSPORT by
	default
Date: Tue, 26 Sep 2017 09:33:21 +0200
Message-ID: <24f71847-7890-4dd5-920a-11b988467e93__32561.093933373$1506411211$gmane$org@de.ibm.com>
References: <1506350729-11311-1-git-send-email-thuth@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506350729-11311-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/25/2017 04:45 PM, Thomas Huth wrote:
> There is no recent user space application available anymore which still
> supports this old virtio transport, so let's disable this by default.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

thanks applied.
> ---
>  arch/s390/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 48af970..923bf04 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -930,7 +930,7 @@ config S390_GUEST
>  	  the KVM hypervisor.
> 
>  config S390_GUEST_OLD_TRANSPORT
> -	def_bool y
> +	def_bool n
>  	prompt "Guest support for old s390 virtio transport (DEPRECATED)"
>  	depends on S390_GUEST
>  	help
> 
