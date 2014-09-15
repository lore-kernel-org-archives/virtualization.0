From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec
	include file
Date: Mon, 15 Sep 2014 12:36:59 +0200
Message-ID: <1410777419.30598.5.camel@nilsson.home.kraxel.org>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
	<5411BD74.80608@redhat.com>
	<1410518696.30411.9.camel@nilsson.home.kraxel.org>
	<20140914134622.GB27315@redhat.com>
	<CAFEAcA8f8kKoDwCd4-rVYHQZXJQSXZcJiqMVRMVzWRvFwUDNRA@mail.gmail.com>
	<20140914141158.GA27836@redhat.com>
	<CAFEAcA_qOoC+C9O-JF_uOD+YRr9fkz35Ju1Q=veFeTSM_XjMtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA_qOoC+C9O-JF_uOD+YRr9fkz35Ju1Q=veFeTSM_XjMtg@mail.gmail.com>
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
Cc: Dave Airlie <airlied@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, QEMU Developers <qemu-devel@nongnu.org>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> >>
> >> Why do you think that? We have several header files which
> >> use QEMU_BUILD_BUG_ON and I don't see any reason why
> >> it would have to be invoked from a .c file.
> 
> > Because Gerd wants to share this with linux uapi, and
> > you can't use BUILD_BUG_ON in uapi headers on linux.
> 
> Who owns the "master" copy of the header and commits
> to making sure it builds on other things than Linux+gcc
> in that case?

In my personal repo the master copy is in the linux tree and qemu gets
synced.  I've placed the QEMU_BUILD_BUG_ON calls in the (qemu-only)
virtio-gpu.c now.

cheers,
  Gerd
