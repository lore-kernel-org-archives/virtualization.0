From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3] vhost cleanups and separate module
Date: Mon, 06 May 2013 15:41:36 +0930
Message-ID: <87sj20prhj.fsf@rustcorp.com.au>
References: <1367559269-8325-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367559269-8325-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:
> Asias He (3):
>   vhost: Remove vhost_enable_zcopy in vhost.h
>   vhost: Move VHOST_NET_FEATURES to net.c
>   vhost: Make vhost a separate module

I like these cleanups, MST pleasee apply.

I have some other cleanups which are on hold for the moment pending
MST's vhost_net simplification.  MST, how's that going?

Thanks,
Rusty.
