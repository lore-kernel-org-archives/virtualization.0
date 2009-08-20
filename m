From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Thu, 20 Aug 2009 20:24:37 +0300
Message-ID: <4A8D86D5.4090809__28760.5725149207$1250789133$gmane$org@redhat.com>
References: <20090810192304.GA16781@redhat.com> <4A808840.70704@codemonkey.ws>
	<20090812173548.GA29981@redhat.com>
	<200908201649.48082.rusty@rustcorp.com.au>
	<20090820170028.GA8908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090820170028.GA8908@redhat.com>
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
Cc: kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/20/2009 08:00 PM, Michael S. Tsirkin wrote:
>
> Surprisingly, I seem to get better-than-userspace throughput with this
> benchmark as well.  Here's a test run locally, host-to-guest,
> over a veth link:
>
> vhost:
> [root@qus19 ~]# ping -c 1000000 -f -q 11.0.0.4
> PING 11.0.0.4 (11.0.0.4) 56(84) bytes of data.
>
> --- 11.0.0.4 ping statistics ---
> 1000000 packets transmitted, 1000000 received, 0% packet loss, time 10230ms
> rtt min/avg/max/mdev = 0.005/0.006/0.035/0.000 ms, ipg/ewma 0.010/0.006 ms
>    

6 microseconds is very impressive for round-trip time.

> [root@qus19 ~]# ping -s 1024 -l 120 -c 1000000 -f -q 11.0.0.4
> PING 11.0.0.4 (11.0.0.4) 1024(1052) bytes of data.
>
> --- 11.0.0.4 ping statistics ---
> 1000000 packets transmitted, 1000000 received, 0% packet loss, time 11270ms
> rtt min/avg/max/mdev = 0.006/0.006/0.022/0.002 ms, pipe 120, ipg/ewma 0.011/0.007 ms
>
>    

That's only 100MB/sec, but understandable given the lack of interrupt 
mitigation.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
