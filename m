From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/12] VMCI for Linux upstreaming
Date: Mon, 29 Oct 2012 19:19:38 -0700
Message-ID: <20121030021938.GC1920@kroah.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: George Zhang <georgezhang@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2012 at 06:03:28PM -0700, George Zhang wrote:
>  drivers/misc/Kconfig                      |    1
>  drivers/misc/Makefile                     |    2
>  drivers/misc/vmw_vmci/Kconfig             |   16
>  drivers/misc/vmw_vmci/Makefile            |   43

Meta comment here, why drivers/misc/?  The other hypervisor
infrastructures all have their own directory under drivers/  Should we
be moving everything to drivers/hyperv/ somehow?

thanks,

greg k-h
