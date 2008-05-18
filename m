From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Sun, 18 May 2008 17:27:05 +0300
Message-ID: <48303CB9.7070406__1248.12601502544$1211121109$gmane$org@qumranet.com>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<200805160925.18087.rusty@rustcorp.com.au>
	<482FCF45.1050307@qumranet.com>
	<200805190016.10823.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805190016.10823.rusty@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> OK.  And since the current situation is that the host doesn't throttle, the 
> feature bit should be "don't throttle, host is doing it for you", and Mark's 
> patch should go in...
>   

Yes.

We should have thought of this before, though, especially as Xen does 
this or something very similar:

> /* Shared ring page */                            \
> struct __name##_sring {                            \
>     RING_IDX req_prod, req_event;                    \
>     RING_IDX rsp_prod, rsp_event;                    \
>     uint8_t  pad[48];                            \
>     union __name##_sring_entry ring[1]; /* variable-length */        \
> };                                    \

req_event and rsp_event allow the other side to indicate when it wants a 
notification.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
