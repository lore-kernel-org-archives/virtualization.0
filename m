From: Krishna Kumar2 <krkumar2@in.ibm.com>
Subject: Re: [PERF RESULTS] virtio and vhost-net performance enhancements
Date: Thu, 26 May 2011 21:59:10 +0530
Message-ID: <OF75734CC8.5E488020-ON6525789C.005A0CF6-6525789C.005A4B7B__34019.1325558864$1306427220$gmane$org@in.ibm.com>
References: <cover.1305846412.git.mst@redhat.com>
	<OF0EFA7BA9.BB2C2860-ON6525789C.0053EE3A-6525789C.005513CC@in.ibm.com>
	<OFE30C8D78.526FF88D-ON8725789C.00563B8C-8825789C.0056469F@us.ibm.com>
	<OFF9D0E604.B865A006-ON6525789C.00597010-6525789C.0059987A@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <OFF9D0E604.B865A006-ON6525789C.00597010-6525789C.0059987A@LocalDomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Krishna Kumar2 <krkumar2@in.ibm.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Steve Dobbelstein <steved@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Krishna Kumar2/India/IBM wrote on 05/26/2011 09:51:32 PM:

> > Could you please try TCP_RRs as well?
>
> Right. Here's the result for TCP_RR:

The actual transaction rate/second numbers are:

_____________________________________________________________
#     RR1      RR2 (%)          SD1        SD2 (%)
_____________________________________________________________
1     9476     9903 (4.5)       28.9       19.8 (-31.4)
2     17337    18225 (5.1)      92.7       83.7 (-9.7)
4     17385    27902 (60.4)     364.8      315.8 (-13.4)
8     25560    42912 (67.8)     1428.1     1234.0 (-13.5)
16    35898    55934 (55.8)     4391.6     4038.1 (-8.0)
32    48048    80228 (66.9)     17391.4    14932.0 (-14.1)
64    60412    88929 (47.2)     71087.7    54230.1 (-23.7)
96    71263    92439 (29.7)     145434.1   128214.0 (-11.8)
128   84208    91014 (8.0)      233668.2   238888.6 (2.2)
_____________________________________________________________
RR: 37.3%     SD: -6.7%
_____________________________________________________________

Thanks,

- KK
