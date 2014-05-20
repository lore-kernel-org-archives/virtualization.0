From: Jidong Xiao <jidong.xiao@gmail.com>
Subject: question about "struct kvm_segment"
Date: Mon, 19 May 2014 22:25:13 -0400
Message-ID: <CAG4AFWbMxbGsLrd_pGzUmwfmq4E3BKDHCZN6xKKqMt2-1dHOXw@mail.gmail.com>
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

Hi,

The structure kvm_segment is defined as follows:

struct kvm_segment {
        __u64 base;
        __u32 limit;
        __u16 selector;
        __u8  type;
        __u8  present, dpl, db, s, l, g, avl;
        __u8  unusable;
        __u8  padding;
};

Since the VMX spec defines base is 64 bits, limit is 32bits, selector
is 16bits, understandably, __u64, __u32, __u16 is used for them
respectively.

However, the VMX spec defines that the access rights is 32bits, which
includes a 4 bits type, 2 bits dpl, and 1 bit for the
present,dpl,db,s,l,g,avl. So why here they are all defined as __u8? It
means that, each of them is represented by 8bits? This looks
inconsistent with the VMX spec.

Hope someone can explain this, thanks!

-Jidong
