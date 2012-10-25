From: Andy King <acking@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 04/10] VMCI: device driver implementaton.
Date: Thu, 25 Oct 2012 14:08:49 -0700 (PDT)
Message-ID: <723255296.2652440.1351199329247.JavaMail.root@vmware.com>
References: <20121025203148.GA28096@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121025203148.GA28096@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Greg,

> You can't just say "general GPL issues aside".  Honestly, given your
> company's prior actions in regards to Linux kernel drivers and the
> licenses of them, I don't trust them at all.  To help gain that trust
> back, marking the exports in this manner will be a great improvement.
> 
> To insist otherwise is to only reinforce my doubts, and reduce my
> wanting to even review or accept this code at all.  Sorry about that.

That's perfectly fair.  In the interest of gaining back some of that
trust, we'll be more than happy to make the exports GPL.  Expect a diff
in the next few days with that change along with any modifications
necessary after a sparse sanity check.

Thanks!
- Andy

PS I finally remembered to drop vm-crosstalk, so hopefully you won't
get anymore annoying bounces.
