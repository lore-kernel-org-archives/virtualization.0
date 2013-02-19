From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/9] virtio: new API for addition of buffers, scatterlist
	changes
Date: Tue, 19 Feb 2013 10:11:14 +0100
Message-ID: <512341B2.6030209@redhat.com>
References: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
	<87r4kjjuyn.fsf@rustcorp.com.au> <511CAD19.2010902@redhat.com>
	<87ehgciw08.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ehgciw08.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 19/02/2013 08:49, Rusty Russell ha scritto:
> 
> But modulo devastating benchmarks, this wins.  Because the three-part
> API is really, really ugly.  It *looks* like a generic "start - work
> ... work - end" API, but it's not.  Because you need to declare exactly
> what you're doing in virtqueue_start_buf!

Fair enough, and since you did the work for me I cannot really complain. :)

Paolo
