From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [FYI] vringh fixes.
Date: Wed, 06 Mar 2013 15:46:32 +1100
Message-ID: <871ubtcezb.fsf@rustcorp.com.au>
References: <1362491468-16681-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com, Ohad Ben-Cohen <ohad@wizery.com>, mst@redhat.com
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

More benchmarking using vringh_test, and I finally figured out that my
changes to virtio_ring had no effect because we were actually
bottlenecked on the vringh side...

Here are the changes I've ended up with, for your reading pleasure.
They are all in my pending-rebases git tree, and I'll fold them together
before putting them into virtio-next (I'm waiting for Sjur's notify
changes).

Cheers,
Rusty.
