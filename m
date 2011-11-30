From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Wed, 30 Nov 2011 18:17:22 +0200
Message-ID: <1322669842.3985.10.camel@lappy>
References: <1322559196-11139-1-git-send-email-levinsasha928@gmail.com>
	<20111129125622.GB19157@redhat.com> <1322573688.4395.11.camel@lappy>
	<20111129135406.GB30966@redhat.com> <1322576464.7003.6.camel@lappy>
	<20111129145451.GD30966@redhat.com> <4ED4F30F.8000603@redhat.com>
	<1322669511.3985.8.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1322669511.3985.8.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: markmc@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Sorry, I forgot to copy-paste one of the results :)

On Wed, 2011-11-30 at 18:11 +0200, Sasha Levin wrote:
> I did some testing of indirect descriptors under different workloads.
> 
> All tests were on a 2 vcpu guest with vhost on. Simple TCP_STREAM using
> netperf.
> 
> Indirect desc off:
> guest -> host, 1 stream: ~4600mb/s
> host -> guest, 1 stream: ~5900mb/s
> guest -> host, 8 streams: ~620mb/s (on average)
> host -> guest, 8 stream: ~600mb/s (on average)
> 
> Indirect desc on:
> guest -> host, 1 stream: ~4900mb/s
> host -> guest, 1 stream: ~5400mb/s
> guest -> host, 8 streams: ~620mb/s (on average)
> host -> guest, 8 stream: ~600mb/s (on average)
Should be:
host -> guest, 8 stream: ~515mb/s (on average)

> 
> Which means that for one stream, guest to host gets faster while host to
> guest gets slower when indirect descriptors are on.
> 

-- 

Sasha.
