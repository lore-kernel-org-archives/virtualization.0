From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/16] lguest: introduce vcpu structure
Date: Wed, 26 Dec 2007 10:54:45 +1100
Message-ID: <200712261054.46261.rusty__41434.6098354601$1198626978$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576363806-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 December 2007 00:33:40 Glauber de Oliveira Costa wrote:
> this patch makes room for the vcpu structure in lguest, already used in
> this very same way at lguest64. It's the first part of our plan to
> have lguest and lguest64 unified too.

Hi Glauber!

    These patches look really solid, thanks!  A few minor things, then I'll 
apply them and push them for 2.6.25.

    My only question is whether we should go further and vpu-ify routines like 
lgread and kill_guest, so that we can avoid more "lg" temporary variables...

> When two dogs hang out, you don't have new puppies right in the other day.
> Some time has to be elapsed. They have to grow first. In this same spirit,
> having these patches _do not_ mean smp guests can be launched (yet)
> Much more work is to come, but this is the basic infrastructure.

OK, that made me laugh...

Thanks!
Rusty.
