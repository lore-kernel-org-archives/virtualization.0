From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Users of ballooning, please come forth!
Date: Tue, 11 Feb 2014 16:31:10 +1030
Message-ID: <8761om2no9.fsf@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all!

        We're debating the design of the balloon for the OASIS spec.
Noone likes the current one, but there are fundamental usage pattern
questions which we're fumbling with.

So if you know anyone who is using it in production?  If, so, how?  In
particular, would you be happy with guests simply giving the host back
whatever memory they can spare (as Xen's self-balloon does)?  Or do you
require the host-forcing approach?  Comment or email please!

Thanks,
Rusty.
