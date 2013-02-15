From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] x86/xen: don't assume %ds is usable in xen_iret
	for 32-bit PVOPS.
Date: Fri, 15 Feb 2013 07:56:10 +0000
Message-ID: <511DF82A02000078000BE932__40681.9487493069$1360914941$gmane$org@nat28.tlf.novell.com>
References: <20130214215216.GA18740@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130214215216.GA18740@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Petr Matousek <pmatouse@redhat.com>, Andrew Cooper <andrew.cooper3@citrix.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>> On 14.02.13 at 22:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> Jan, any reason why this patch isn't in Linus's tree already,

I see Konrad answered that already, and with the embargo on the
CVE having expired only on Tuesday, I think it's not unreasonable
to not see this there yet.

> and why it
> wasn't marked for inclusion in a -stable kernel release?

Forgot to put the tag on when putting the patch together, and
then none of the reviewers noticed either. I'm sorry for that.

Jan
