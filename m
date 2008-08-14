From: David Collier-Brown <davecb@sun.com>
Subject: Re: RFC: I/O bandwidth controller
Date: Thu, 14 Aug 2008 07:18:13 -0400
Message-ID: <48A41475.4070108__36486.6173630164$1218727345$gmane$org@sun.com>
References: <1218117578.11703.81.camel@sebastian.kern.oss.ntt.co.jp>
	<48A0A689.40908@gmail.com> <loom.20080812T071504-212@post.gmane.org>
	<20080812.201025.57762305.taka@valinux.co.jp>
	<48A18854.9020000@gmail.com>
Reply-To: davecb@sun.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <48A18854.9020000@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: righi.andrea@gmail.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, dm-devel@redhat.com, agk@sourceware.org, baramsori72@gmail.com, dave@linux.vnet.ibm.com, ngupta@google.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Andrea Righi wrote:
> A more complicated issue is how to evaluate the total IO bandwidth of a
> generic device. We can use some kind of averaging/prediction, but
> basically it would be inaccurate due to the mechanic of disks (head
> seeks, but also caching, buffering mechanisms implemented directly into
> the device, etc.). It's a hard problem. And the same problem exists also
> for proportional bandwidth as well, in terms of IO rate predictability I
> mean.

  Actually it's a little-known easy problem.

  The capacity planning community does it all the time, but then describes
it in terms that are only interesting (intelligible?) to an enthusiastic
amateur mathematician (;-))

  One finds the point, called N*, at which the throughput flattens
out and and the response time starts to grow without bounds, and
calls that level the maximum.

  In practice, one does an easier variant.  One sets a response-time 
limit and throttles *everyone* proportionally when th disk starts to 
regularly degrade beyond the limit.  Interestingly, because we're 
slowing the application to prevent slowing the disks, the value we 
pick needn't be terribly precise.  It also doesn't require any pre-
knowledge about the disks.

  Send me a note if you want to discuss this in more detail.

--dave
-- 
David Collier-Brown            | Always do right. This will gratify
Sun Microsystems, Toronto      | some people and astonish the rest
davecb@sun.com                 |                      -- Mark Twain
cell: (647) 833-9377, bridge: (877) 385-4099 code: 506 9191#
