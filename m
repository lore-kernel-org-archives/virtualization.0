From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_blk: Drop unused request tracking list
Date: Tue, 08 May 2012 13:38:54 +0930
Message-ID: <87k40nco15.fsf@rustcorp.com.au>
References: <1333077850-21717-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1333077850-21717-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 30 Mar 2012 11:24:10 +0800, Asias He <asias@redhat.com> wrote:
> Benchmark shows small performance improvement on fusion io device.
> 
> Before:
>   seq-read : io=1,024MB, bw=19,982KB/s, iops=39,964, runt= 52475msec
>   seq-write: io=1,024MB, bw=20,321KB/s, iops=40,641, runt= 51601msec
>   rnd-read : io=1,024MB, bw=15,404KB/s, iops=30,808, runt= 68070msec
>   rnd-write: io=1,024MB, bw=14,776KB/s, iops=29,552, runt= 70963msec
> 
> After:
>   seq-read : io=1,024MB, bw=20,343KB/s, iops=40,685, runt= 51546msec
>   seq-write: io=1,024MB, bw=20,803KB/s, iops=41,606, runt= 50404msec
>   rnd-read : io=1,024MB, bw=16,221KB/s, iops=32,442, runt= 64642msec
>   rnd-write: io=1,024MB, bw=15,199KB/s, iops=30,397, runt= 68991msec
> 
> Signed-off-by: Asias He <asias@redhat.com>

Thanks.  It didn't really need a benchmark to justify this cleanup, but
you certainly get points for thoroughness!

Applied,
Rusty.
