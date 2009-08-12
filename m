From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Wed, 12 Aug 2009 20:35:48 +0300
Message-ID: <20090812173548.GA29981__14770.1708636761$1250098731$gmane$org@redhat.com>
References: <20090810192304.GA16781@redhat.com> <4A808840.70704@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A808840.70704@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 10, 2009 at 03:51:12PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> This adds support for vhost-net virtio kernel backend.
>>
>> This is RFC, but works without issues for me.
>>
>> Still needs to be split up, tested and benchmarked properly,
>> but posting it here in case people want to test drive
>> the kernel bits I posted.
>>   
>
> Any rough idea on performance?  Better or worse than userspace?
>
> Regards,
>
> Anthony Liguori

Well, I definitely see some gain in latency.
Here's a simple test over a 1G ethernet link (host to guest):

Native:
[root@qus18 ~]# netperf -H 11.0.0.1 -t udp_rr
UDP REQUEST/RESPONSE TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 11.0.0.1 (11.0.0.1) port 0 AF_INET
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

126976 126976 1        1       10.00    10393.23
124928 124928


vhost virtio:
[root@qus18 ~]# netperf -H 11.0.0.3 -t udp_rr
UDP REQUEST/RESPONSE TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 11.0.0.3 (11.0.0.3) port 0 AF_INET
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

126976 126976 1        1       10.00    8169.58
124928 124928

Userspace virtio:
[root@qus18 ~]# netperf -H 11.0.0.3 -t udp_rr
UDP REQUEST/RESPONSE TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 11.0.0.3 (11.0.0.3) port 0 AF_INET
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

126976 126976 1        1       10.00    2029.49
124928 124928


Part of it might be that tx mitigation does not come into play with vhost. I
need to disable it in qemu and see.

-- 
MST
