From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec
	include file
Date: Thu, 11 Sep 2014 17:40:54 +0200
Message-ID: <1410450054.8604.14.camel@nilsson.home.kraxel.org>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
	<CAFEAcA9TZPxJi9V8EYTKvgQ_tj8VgrHTT_CRQ0=O8KhuX7tH7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA9TZPxJi9V8EYTKvgQ_tj8VgrHTT_CRQ0=O8KhuX7tH7w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Airlie <airlied@redhat.com>, virtio-dev@lists.oasis-open.org, QEMU Developers <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > +enum virtgpu_ctrl_type {
> > +        VIRTGPU_UNDEFINED = 0,
> >
> 
> This is clearly all well out of line with our
> coding style guide, which isn't a terribly good start...

Oh yea, code style is fun.  This file is needed in both qemu & linux
kernel, which have different code styles.  I pipe it though a sed script
already when syncing them up, weeding out the tabs.  I'll go tweak my
script to fix the indent too.

cheers,
  Gerd
