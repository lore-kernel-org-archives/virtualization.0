From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.29 git, resume from ram broken on thinkpad
Date: Wed, 1 Apr 2009 14:00:54 -0700
Message-ID: <20090401210054.GS18394@sequoia.sous-sol.org>
References: <200904011155.20751.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904011155.20751.a.miskiewicz@gmail.com>
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
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Yinghai Lu <yhlu.kernel@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

* Arkadiusz Miskiewicz (a.miskiewicz@gmail.com) wrote:
> and this as bad commit:
> 
> 7f7ace0cda64c99599c23785f8979a072e118058 is first bad commit

Does it make any difference if you roll fwd a couple commits to:

802bf931f2688ad125b73db597ce63cc842fb27a

That fixes a possible problem with the cpumask change and interrupt
migration.

And to be clear, one commit earlier works?

fae3e7fba4c664b3a15f2cf15ac439e8d754afc2

thanks,
-chris
