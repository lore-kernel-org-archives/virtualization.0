From: "Dor Laor" <dor.laor@qumranet.com>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 00:33:44 -0700
Message-ID: <64F9B87B6B770947A9F8391472E032160D464FEB__38348.7611696639$1187681752$gmane$org@ehost011-8.exch011.intermedia.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net><1187313953.6449.70.camel@localhost.localdomain><1187328402.4363.110.camel@ghaskins-t60p.haskins.net><1187336618.6449.106.camel@localhost.localdomain><1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1187652496.19435.141.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Gregory Haskins <ghaskins@novell.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

>> > Well, for cache reasons you should really try to avoid having both
>sides
>> > write to the same data.  Hence two separate cache-aligned regions
is
>> > better than one region and a flip bit.
>>
>> While I certainly can see what you mean about the cache implications
>for
>> a bit-flip design, I don't see how you can get away with not having
>both
>> sides write to the same memory in other designs either.  Wouldn't you
>> still have to adjust descriptors from one ring to the other?  E.g.
>> wouldn't both sides be writing descriptor pointer data in this case,
>or
>> am I missing something?
>
>Hi Gregory,
>
>	You can have separate produced and consumed counters: see for
>example
>Van Jacobson's Netchannels presentation
>http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf page 23.
>
>	This single consumed count isn't sufficient if you can consume
>out-of-order: for that you really want a second "reply" ringbuffer
>indicating what buffers are consumed.
>

Rusty, although your code works pretty nice, (I'll send some raw patches
later on today with 
kvm support for virtio). I was wandering why didn't you use Xen's ring
implementation?
They have separate counters and also union for the request/response
structure in the same
descriptor.
Here is some of it + lxr link:

http://81.161.245.2/lxr/http/source/xen/include/public/io/ring.h?v=xen-3
.1.0-src;a=m68k


80 #define DEFINE_RING_TYPES(__name, __req_t, __rsp_t)
\
 81
\
 82 /* Shared ring entry */
\
 83 union __name##_sring_entry {
\
 84     __req_t req;
\
 85     __rsp_t rsp;
\
 86 };
\
 87
\
 88 /* Shared ring page */
\
 89 struct __name##_sring {
\
 90     RING_IDX req_prod, req_event;
\
 91     RING_IDX rsp_prod, rsp_event;
\
 92     uint8_t  pad[48];
\
 93     union __name##_sring_entry ring[1]; /* variable-length */
\
 94 };
\
 95
\
 96 /* "Front" end's private variables */
\
 97 struct __name##_front_ring {
\
 98     RING_IDX req_prod_pvt;
\
 99     RING_IDX rsp_cons;
\
100     unsigned int nr_ents;
\
101     struct __name##_sring *sring;
\
102 };
\
103
\
104 /* "Back" end's private variables */
\
105 struct __name##_back_ring {
\
106     RING_IDX rsp_prod_pvt;
\
107     RING_IDX req_cons;
\
108     unsigned int nr_ents;
\
109     struct __name##_sring *sring;
\
110 };
\
111
\
112 /* Syntactic sugar */
\
113 typedef struct __name##_sring __name##_sring_t;
\
114 typedef struct __name##_front_ring __name##_front_ring_t;
\
115 typedef struct __name##_back_ring __name##_back_ring_t
