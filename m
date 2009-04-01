From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Wed, 1 Apr 2009 16:06:37 -0700
Message-ID: <20090401230637.GW18394@sequoia.sous-sol.org>
References: <200904011155.20751.a.miskiewicz@gmail.com>
	<200904012349.10919.rjw@sisk.pl>
	<20090401221433.GV18394@sequoia.sous-sol.org>
	<200904020023.58363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904020023.58363.rjw@sisk.pl>
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
> Sorry for the misunderstanding, I thought the breakage might be introduced
> between 15f7176eb1cccec0a332541285ee752b935c1c85 and
> 0a0c5168df270a50e3518e4f12bddb31f8f5f38f, so I thought it would be a good
> idea to verify if 0a0c5168df270a50e3518e4f12bddb31f8f5f38f fails too.

Ah, sure.  It fails too (both test_suspend=mem and regular suspend/resume).
