From: Andrew Stiegmann <astiegmann@vmware.com>
Subject: Re: [vmw_vmci RFC 01/11] Apply VMCI context code
Date: Wed, 16 May 2012 11:34:35 -0700 (PDT)
Message-ID: <338409537.3067117.1337193275440.JavaMail.root__19816.4779147648$1337708058$gmane$org@zimbra-prod-mbox-4.vmware.com>
References: <20120516100121.3be6d0ca@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120516100121.3be6d0ca@nehalam.linuxnetplumber.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@vyatta.com>, gregkh@linuxfoundation.org
Cc: acking@vmware.com, dtor@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dsouders@vmware.com, akpm@linux-foundation.org, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

Both of your comments have been added to my "to do" list before the next time I publish.  Thanks for the feedback.

----- Original Message -----
> From: "Stephen Hemminger" <shemminger@vyatta.com>
> To: "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>
> Cc: linux-kernel@vger.kernel.org, acking@vmware.com, dtor@vmware.com, gregkh@linuxfoundation.org,
> virtualization@lists.linux-foundation.org, dsouders@vmware.com, akpm@linux-foundation.org, cschamp@vmware.com
> Sent: Wednesday, May 16, 2012 10:01:21 AM
> Subject: Re: [vmw_vmci RFC 01/11] Apply VMCI context code
> 
> On Tue, 15 May 2012 08:06:58 -0700
> "Andrew Stiegmann (stieg)" <astiegmann@vmware.com> wrote:
> 
> > Context code maintains state for vmci and allows the driver
> > to communicate with multiple VMs.
> > 
> > Signed-off-by: Andrew Stiegmann (stieg) <astiegmann@vmware.com>
> 
> Running checkpatch reveals the usual noise, and the following that
> should be addressed.
> 
> ERROR: do not use C99 // comments
> #272: FILE: drivers/misc/vmw_vmci/vmci_context.c:183:
> +static bool ctx_exists_locked(uint32_t cid)	// IN
> 
> ERROR: "foo * bar" should be "foo *bar"
> #304: FILE: drivers/misc/vmw_vmci/vmci_context.c:215:
> +		      uid_t * user, struct vmci_ctx **outContext)
> 
> I don't mind the C99 style comments, but the // IN convention
> is pretty useless and should be removed.
> 
