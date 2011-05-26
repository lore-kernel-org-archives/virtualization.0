From: Krishna Kumar2 <krkumar2@in.ibm.com>
Subject: [PERF RESULTS] virtio and vhost-net performance enhancements
Date: Thu, 26 May 2011 21:02:11 +0530
Message-ID: <OF0EFA7BA9.BB2C2860-ON6525789C.0053EE3A-6525789C.005513CC__44433.4504697055$1306423817$gmane$org@in.ibm.com>
References: <cover.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1305846412.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> wrote on 05/20/2011 04:40:07 AM:

> OK, here is the large patchset that implements the virtio spec update
> that I sent earlier (the spec itself needs a minor update, will send
> that out too next week, but I think we are on the same page here
> already). It supercedes the PUBLISH_USED_IDX patches I sent
> out earlier.

I was able to get this tested by applying the v2 patches
to git-next tree (somehow MST's git tree hung on my guest
which never got resolved). Testing was from Guest -> Remote
node, using an ixgbe 10g card. The test results are
*excellent* (table: #netperf sesssions, BW% improvement,
SD% improvement, CPU% improvement):

___________________________________
           512 byte I/O
#     BW%     SD%      CPU%
____________________________________
1     151.6   -65.1    -10.7
2     180.6   -66.6    -6.4
4     15.5    -35.8    -26.1
8     1.8     -28.4    -26.7
16    3.1     -29.0    -26.5
32    1.1     -27.4    -27.5
64    3.8     -30.9    -26.7
96    5.4     -21.7    -24.2
128   5.7     -24.4    -25.5
____________________________________
BW: 16.6%   SD: -24.6%    CPU: -25.5%


____________________________________
            1K I/O
#     BW%     SD%      CPU%
____________________________________
1     233.9   -76.5    -18.0
2     112.2   -64.0    -23.2
4     9.2     -31.6    -26.1
8    -1.7     -26.8    -30.3
16    3.5     -31.5    -30.6
32    4.8     -25.2    -30.5
64    5.7     -31.0    -28.9
96    5.3     -32.2    -31.7
128   4.6     -38.2    -33.6
____________________________________
BW: 16.4%   SD: -35.%    CPU: -31.5%


____________________________________
             16K I/O
#     BW%     SD%      CPU%
____________________________________
1     18.8    -27.2    -18.3
2     14.8    -36.7    -27.7
4     12.7    -45.2    -38.1
8     4.4     -56.4    -54.4
16    4.8     -38.3    -36.1
32    0        78.0     79.2
64    3.8     -38.1    -37.5
96    7.3     -35.2    -31.1
128   3.4     -31.1    -32.1
____________________________________
BW: 7.6%   SD: -30.1%   CPU: -23.7%


I plan to run some more tests tomorrow. Please let
me know if any other scenario will help.

Thanks,

- KK
