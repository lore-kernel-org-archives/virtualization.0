From: Michael Dalton <mwdalton@google.com>
Subject: Re: [PATCH net-next] virtio_net: migrate mergeable rx buffers to page
	frag allocators
Date: Tue, 29 Oct 2013 12:05:27 -0700
Message-ID: <CANJ5vP+=wCrzJ3Fdg0_5ZTTT-V-fw2AXUG=EgwsUcxXO=UpMgw__3478.5448959612$1383073559$gmane$org@mail.gmail.com>
References: <1383000258-1458-1-git-send-email-mwdalton@google.com>
	<CAG7+5M1VFSZciaZf+Y_yzm=aq1Z4fZ-QgACN2srnC9twOWhVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG7+5M1VFSZciaZf+Y_yzm=aq1Z4fZ-QgACN2srnC9twOWhVWw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Northup <digitaleric@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, lf-virt <virtualization@lists.linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Agreed Eric, the buffer size should be increased so that we can accommodate a
MTU-sized packet + mergeable virtio net header in a single buffer. I will send
a patch to fix shortly cleaning up the #define headers as Rusty indicated and
increasing the buffer size slightly by VirtioNet header size bytes per Eric.

Jason, I'll followup with you directly - I'd like to know your exact workload
(single steam or multi-stream netperf?), VM configuration, etc, and also see if
the nit that Erichas pointed out affects your results.  It is also
worth noting that
we may want to tune the queue sizes for your benchmarks, e.g, by reducing
buffer size from 4KB to MTU-sized but keeping queue length constant, we're
implicitly decreasing the number of bytes stored in the VirtioQueue for the
VirtioNet device, so increasing the queue size may help.

Best,

Mike
