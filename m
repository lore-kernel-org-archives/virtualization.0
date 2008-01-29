From: INAKOSHI Hiroya <inakoshi.hiroya@jp.fujitsu.com>
Subject: Re: [Xen-devel] dm-band: The I/O bandwidth controller: Performance
 Report
Date: Tue, 29 Jan 2008 15:42:17 +0900
Message-ID: <479ECAC9.5070709__27941.0509429455$1201621326$gmane$org@jp.fujitsu.com>
References: <20080123.215350.193721890.ryov@valinux.co.jp>
	<20080125.160720.183032233.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080125.160720.183032233.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: containers@lists.linux-foundation.org, dm-devel@redhat.com, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Ryo Tsuruta wrote:
> The results of bandwidth control test on band-groups.
> =====================================================
> The configurations of the test #3:
>    o Prepare three partitions sdb5 and sdb6.
>    o Create two extra band-groups on sdb5, the first is of user1 and the
>      second is of user2.
>    o Give weights of 40, 20, 10 and 10 to the user1 band-group, the user2
>      band-group, the default group of sdb5 and sdb6 respectively.
>    o Run 128 processes issuing random read/write direct I/O with 4KB data
>      on each device at the same time.

you mean that you run 128 processes on each user-device pairs?  Namely,
I guess that

  user1: 128 processes on sdb5,
  user2: 128 processes on sdb5,
  another: 128 processes on sdb5,
  user2: 128 processes on sdb6.

> Conclusions and future works
> ============================
> Dm-band works well with random I/Os. I have a plan on running some tests
> using various real applications such as databases or file servers.
> If you have any other good idea to test dm-band, please let me know.

The second preliminary studies might be:

- What if you use a different I/O size on each device (or device-user pair)?
- What if you use a different number of processes on each device (or
device-user pair)?


And my impression is that it's natural dm-band is in device-mapper,
separated from I/O scheduler.  Because bandwidth control and I/O
scheduling are two different things, it may be simpler that they are
implemented in different layers.

Regards,

Hiroya.


> 
> Thank you,
> Ryo Tsuruta.
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
> 
> 
