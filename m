From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 02/14] virtio: console: Remove control vq data only if
	using multiport support
Date: Mon, 6 Sep 2010 15:52:08 +0530
Message-ID: <20100906102208.GA4088@amit-laptop.redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
	<c7259c88e3dc036806629cd31f08e8b54fa1c345.1283430900.git.amit.shah@redhat.com>
	<201009061759.40423.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009061759.40423.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Sep 06 2010 [17:59:39], Rusty Russell wrote:
> On Thu, 2 Sep 2010 10:11:41 pm Amit Shah wrote:
> > If a portdev isn't using multiport support, it won't have any control vq
> > data to remove.
> > 
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> 
> So previously it would crash if it was ever removed?  If so, it'd be
> nice to see that in the patch description :)

Well, yeah.  If any module remove or port / device remove was performed
earlier, there would be crashes in multiple places (as noted in the
0/14) message.  I didn't want to scare away people by repeating it for
each patch ;-)

You're right, though, I should've mentioned it.  The 0/N message gets
lost and the commit history won't reflect that info.

Thanks for picking them up!

		Amit
