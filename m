From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH 2/2] xen: remove bm_rld_set of xen_processor_flags
Date: Tue, 04 Jun 2013 09:13:24 +0100
Message-ID: <51ADBDC402000078000DAF36@nat28.tlf.novell.com>
References: <1370333128-11412-1-git-send-email-lig.fnst@cn.fujitsu.com>
	<1370333128-11412-2-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1370333128-11412-2-git-send-email-lig.fnst@cn.fujitsu.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: liguang <lig.fnst@cn.fujitsu.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Liu Jinsong <jinsong.liu@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 04.06.13 at 10:05, liguang <lig.fnst@cn.fujitsu.com> wrote:
> bm_rld_set seems obsolete now
> 
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> ---
>  include/xen/interface/platform.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/include/xen/interface/platform.h 
> b/include/xen/interface/platform.h
> index c57d5f6..7ffff33 100644
> --- a/include/xen/interface/platform.h
> +++ b/include/xen/interface/platform.h
> @@ -240,7 +240,6 @@ struct xen_processor_flags {
>  	uint32_t bm_check:1;
>  	uint32_t has_cst:1;
>  	uint32_t power_setup_done:1;
> -	uint32_t bm_rld_set:1;
>  };
>  
>  struct xen_processor_power {

Any such patch would need to be submitted against the master copy
of the header (in the Xen repo), and by recognizing that you'd also
notice that this is part of a public ABI, and hence can't be removed,
but at best can be documented as obsolete. Of course you'd first
need to check whether the hypervisor makes any use of that bit
when passed down from Dom0.

Jan
