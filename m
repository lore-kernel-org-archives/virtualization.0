From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 2/5] /dev/vring: simple userspace-kernel ringbuffer
	interface.
Date: Sat, 19 Apr 2008 20:33:22 +0400
Message-ID: <20080419163322.GA17089__28238.8854226612$1208790574$gmane$org@2ka.mipt.ru>
References: <200804181433.48488.rusty@rustcorp.com.au>
	<200804181439.49051.rusty@rustcorp.com.au>
	<20080419102214.GA21952@2ka.mipt.ru>
	<200804200205.31508.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804200205.31508.rusty@rustcorp.com.au>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Apr 20, 2008 at 02:05:31AM +1000, Rusty Russell (rusty@rustcorp.com.au) wrote:
> > Should this whole function and vring_used_buffer() be protected with
> > vr->lock mutex?
> 
> No; it's up to the caller to make sure that they are serialized.  In the case 
> of tun that happens naturally.
> 
> There are two reasons not to grab the lock.  It turns out that if we tried to 
> lock here, we'd deadlock, since the callbacks are called under the lock.  
> Secondly, it's possible to implement an atomic vring_used_buffer variant, 
> which could fail: this would avoid using the thread most of the time.

Yep, I decided that too. But it limits its usage to tun only or any
other system where only single thread picks up results, so no generic
userspace ring buffers?

-- 
	Evgeniy Polyakov
