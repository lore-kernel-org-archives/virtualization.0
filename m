From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH 2/2] virtio-gpu/2d: add
	docs/specs/virtio-gpu.txt
Date: Mon, 15 Sep 2014 12:14:45 +0200
Message-ID: <1410776085.30598.1.camel@nilsson.home.kraxel.org>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-3-git-send-email-kraxel@redhat.com>
	<20140912091011.GC1614@stefanha-thinkpad.redhat.com>
	<1410521887.30411.13.camel@nilsson.home.kraxel.org>
	<CAPM=9ty=xhETM++JebrkKoSoPQHGdvNcC_wU2jytZVo_wqETQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9ty=xhETM++JebrkKoSoPQHGdvNcC_wU2jytZVo_wqETQA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Sa, 2014-09-13 at 07:14 +1000, Dave Airlie wrote:
> >> Can the host refuse due to lack of resources?
> >
> > Yes.  virtgpu_ctrl_hdr.type in the response will be set to
> > VIRTGPU_RESP_ERR_* then.  Current implementation does that only on
> > malloc() failure, there is no accounting (yet) to limit the amout of
> > memory the guest is allowed to allocate.
> 
> We do probably need to work out some sort of accounting system, it can
> probably reliably only be a total value of resources, since we've no
> idea if the host driver will store them in VRAM or main memory. Quite
> how to fail gracefully is a question, probably need to report to the
> guest what context did the allocation and see if we can destroy it.

Best would be if virgilrenderer.so just fails
virgl_renderer_resource_create() calls.

> Not reason I can remember, I think I was thinking of having separate
> inval and detach at one point, but it didn't really make any sense, so
> renaming to detach is fine with me.

Done.

cheers,
  Gerd
