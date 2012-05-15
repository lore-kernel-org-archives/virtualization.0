From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [vmw_vmci RFC 01/11] Apply VMCI context code
Date: Tue, 15 May 2012 16:47:43 -0700
Message-ID: <20120515234743.GA1758__26725.4140032039$1337186490$gmane$org@kroah.com>
References: <1337094428-20453-1-git-send-email-astiegmann@vmware.com>
	<1337094428-20453-2-git-send-email-astiegmann@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1337094428-20453-2-git-send-email-astiegmann@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>
Cc: acking@vmware.com, dtor@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dsouders@vmware.com, akpm@linux-foundation.org, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 15, 2012 at 08:06:58AM -0700, Andrew Stiegmann (stieg) wrote:
> +/*
> + *----------------------------------------------------------------------
> + *
> + * ctx_signal_notify --
> + *
> + *      Sets the notify flag to true.  Assumes that the context lock is
> + *      held.
> + *
> + * Results:
> + *      None.
> + *
> + * Side effects:
> + *      None.
> + *
> + *----------------------------------------------------------------------
> + */
> +
> +static void ctx_signal_notify(struct vmci_ctx *context)
> +{
> +	if (context->notify)
> +		*context->notify = true;
> +}

What's with the bizarre comment block format here and throughout the
code?  Care to fix it up (i.e. delete it all from static functions, and
use kerneldoc for public functions.)

thanks,

greg k-h
