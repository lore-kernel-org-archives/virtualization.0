From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Wed, 29 Aug 2012 22:46:19 +0200
Message-ID: <503E7F9B.8010402@gmail.com>
References: <1346159043-16446-1-git-send-email-levinsasha928@gmail.com>
	<1346159043-16446-2-git-send-email-levinsasha928@gmail.com>
	<20120829153812.GD7407@redhat.com> <503E4DD9.1020102@gmail.com>
	<20120829181235.GE7877@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120829181235.GE7877@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/29/2012 08:12 PM, Michael S. Tsirkin wrote:
>>> > > What is a good default for net? I guess max sg?
>> > 
>> > I think that it depends on the workload. I'd say we should keep the default to 0
>> > (disabled) unless we can have a good way to adjust it to the load.
> For *all* drivers?
> 
> Then it is mostly useless. No one has the time to tweak module
> parameters in real life.
> 
> For virtio-net, 16+1 is not too much and ensures we always
> use the cache.
> 
> If that works better than 0 I would say run with 17.

I was being extra-cautious with leaving it disabled until specifically enabled
because I assumed that this would be one of the first comments I'll get if it
was enabled by default :)

If you're comfortable with setting it to a sane default like 17, I'm perfectly
fine with that as well.


Thanks,
Sasha
