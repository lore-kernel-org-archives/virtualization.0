From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Wed, 1 Apr 2009 14:37:56 -0700
Message-ID: <20090401213756.GU18394@sequoia.sous-sol.org>
References: <200904011155.20751.a.miskiewicz@gmail.com>
	<200904012329.21362.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904012329.21362.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: xen-devel@lists.xensource.com, Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Yinghai Lu <yhlu.kernel@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> This may be caused by the recent PM changes.  Can you please test if commit
> 8efb8c76fcdccf5050c0ea059dac392789baaff2 is fine?

I just tested on my t400, it's not[1].  See same symptoms as Arkadiusz.
Seems as if it responds to initial apci event, I see some disk activity,
then nothing (as if it tried to wakeup, then went back to sleep).

[1] 15f7176eb1cccec0a332541285ee752b935c1c85 bad
    fae3e7fba4c664b3a15f2cf15ac439e8d754afc2 good(ish) (display stays blank)
