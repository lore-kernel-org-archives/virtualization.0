From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] [PATCH 04/10] VMCI: device driver implementaton.
Date: Fri, 26 Oct 2012 13:11:23 -0700
Message-ID: <20121026201123.GA15366__2519.46333232826$1351282699$gmane$org@kroah.com>
References: <723255296.2652440.1351199329247.JavaMail.root@vmware.com>
	<1734741434.3740170.1351281773036.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1734741434.3740170.1351281773036.JavaMail.root@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy King <acking@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 26, 2012 at 01:02:53PM -0700, Andy King wrote:
> Hi Greg,
> 
> > in the next few days with that change along with any modifications
> > necessary after a sparse sanity check.
> 
> We have a change that fixes things, but I wanted to check if you
> had any additional comments before we send out more patches.  In
> all likelihood you'd probably already given up in disgust after
> the vanilla exports, but I wanted to be sure :)

Yes, I stopped reviewing at this point.

> Also, would you prefer a complete refresh of the series or just
> diffs?

Complete refresh, with a short summary on the 00/10 patch of what the
changes are.  That's the usual way to do this type of thing.

thanks,

greg k-h
