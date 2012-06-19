From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v2 0/3] Improve virtio-blk performance
Date: Tue, 19 Jun 2012 12:24:24 +0800
Message-ID: <4FDFFEF8.9000609@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<CAJSP0QXOn-5Krm6hSMmm=zRYkG43k9F4Xe6P+ENMFtgMhTupFA@mail.gmail.com>
	<4FDEF73E.3010501@redhat.com>
	<CAJSP0QXj0brxkTRGCMcjYU3AZwFbk+O5D2ATNz8GLECt9rNs7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QXj0brxkTRGCMcjYU3AZwFbk+O5D2ATNz8GLECt9rNs7w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/18/2012 06:58 PM, Stefan Hajnoczi wrote:
> As long as the latency is decreasing that's good.  But It's worth
> keeping in mind that these percentages are probably wildly different
> on real storage devices and/or qemu-kvm.  What we don't know here is
> whether this bottleneck matters in real environments - results with
> real storage and with qemu-kvm would be interesting.

Yes. Here is the performance data on a Fusion-IO SSD device.

Fio test is performed in a 8 vcpu guest with Fusion-IO based guest using 
kvm tool.

     Short version:
      With bio-based IO path, sequential read/write, random read/write
      IOPS boost         : 11%, 11%, 13%, 10%
      Latency improvement: 10%, 10%, 12%, 10%

     Long Version:
      With bio-based IO path:
       read : io=2048.0MB, bw=58920KB/s, iops=117840 , runt= 35593msec
       write: io=2048.0MB, bw=64308KB/s, iops=128616 , runt= 32611msec
       read : io=3095.7MB, bw=59633KB/s, iops=119266 , runt= 53157msec
       write: io=3095.7MB, bw=62993KB/s, iops=125985 , runt= 50322msec
         clat (usec): min=0 , max=1284.3K, avg=128109.01, stdev=71513.29
         clat (usec): min=94 , max=962339 , avg=116832.95, stdev=65836.80
         clat (usec): min=0 , max=1846.6K, avg=128509.99, stdev=89575.07
         clat (usec): min=0 , max=2256.4K, avg=121361.84, stdev=82747.25
cpu : usr=56.79%, sys=421.70%, ctx=147335118, majf=21080, minf=19852517
cpu : usr=61.81%, sys=455.53%, ctx=143269950, majf=16027, minf=24800604
cpu : usr=63.10%, sys=455.38%, ctx=178373538, majf=16958, minf=24822612
cpu : usr=62.04%, sys=453.58%, ctx=226902362, majf=16089, minf=23278105

      With request-based IO path:
       read : io=2048.0MB, bw=52896KB/s, iops=105791 , runt= 39647msec
       write: io=2048.0MB, bw=57856KB/s, iops=115711 , runt= 36248msec
       read : io=3095.7MB, bw=52387KB/s, iops=104773 , runt= 60510msec
       write: io=3095.7MB, bw=57310KB/s, iops=114619 , runt= 55312msec
         clat (usec): min=0 , max=1532.6K, avg=142085.62, stdev=109196.84
         clat (usec): min=0 , max=1487.4K, avg=129110.71, stdev=114973.64
         clat (usec): min=0 , max=1388.6K, avg=145049.22, stdev=107232.55
         clat (usec): min=0 , max=1465.9K, avg=133585.67, stdev=110322.95
cpu : usr=44.08%, sys=590.71%, ctx=451812322, majf=14841, minf=17648641
cpu : usr=48.73%, sys=610.78%, ctx=418953997, majf=22164, minf=26850689
cpu : usr=45.58%, sys=581.16%, ctx=714079216, majf=21497, minf=22558223
cpu : usr=48.40%, sys=599.65%, ctx=656089423, majf=16393, minf=23824409


-- 
Asias
