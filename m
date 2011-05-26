From: Krishna Kumar2 <krkumar2@in.ibm.com>
Subject: Re: [PERF RESULTS] virtio and vhost-net performance enhancements
Date: Thu, 26 May 2011 21:51:32 +0530
Message-ID: <OFF9D0E604.B865A006-ON6525789C.00597010-6525789C.0059987A__12283.0885964961$1306426770$gmane$org@in.ibm.com>
References: <cover.1305846412.git.mst@redhat.com>
	<OF0EFA7BA9.BB2C2860-ON6525789C.0053EE3A-6525789C.005513CC@in.ibm.com>
	<OFE30C8D78.526FF88D-ON8725789C.00563B8C-8825789C.0056469F@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <OFE30C8D78.526FF88D-ON8725789C.00563B8C-8825789C.0056469F@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shirley Ma <xma@us.ibm.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Steve Dobbelstein <steved@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Shirley Ma <xma@us.ibm.com> wrote on 05/26/2011 09:12:22 PM:

> Could you please try TCP_RRs as well?

Right. Here's the result for TCP_RR:

__________________________________
#       RR%     SD%     CPU%
__________________________________
1       4.5       -31.4    -27.9
2       5.1       -9.7      -5.4
4       60.4     -13.4     38.8
8       67.8     -13.5     45.0
16     55.8     -8.0       43.2
32     66.9     -14.1     43.3
64     47.2     -23.7     12.2
96     29.7     -11.8     14.3
128    8.0       2.2       10.7
___________________________________
BW: 37.3%   SD: -6.7%   CPU: 15.7%
___________________________________

Thanks,

- KK
