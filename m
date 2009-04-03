From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Thu, 2 Apr 2009 17:35:23 -0700
Message-ID: <20090403003523.GK18394@sequoia.sous-sol.org>
References: <200904011155.20751.a.miskiewicz@gmail.com>
	<20090402210451.GA4076@elte.hu> <200904022328.02088.rjw@sisk.pl>
	<200904030222.57469.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904030222.57469.a.miskiewicz@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, virtualization@lists.osdl.org, Yinghai Lu <yhlu.kernel@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

* Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> What about 9ea09af3bd3090e8349ca2899ca2011bd94cda85 ?
> 
> stop_machine: introduce stop_machine_create/destroy.

That is later fixed in a0e280e0f33f6c859a235fb69a875ed8f3420388.

Can you please verify if 2.6.29 works for you?  Your bisects are all
going way back to 2.6.29-rc1.

thanks,
-chris
