From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec
	include file
Date: Sun, 14 Sep 2014 18:09:31 +0300
Message-ID: <20140914150931.GA28042@redhat.com>
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
Content-Disposition: inline
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Dave Airlie <airlied@redhat.com>, virtio-dev@lists.oasis-open.org, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 14, 2014 at 07:32:21AM -0700, Peter Maydell wrote:
> On 14 September 2014 07:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Sun, Sep 14, 2014 at 07:04:11AM -0700, Peter Maydell wrote:
> >> On 14 September 2014 06:46, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > BUILD_BUG_ON in linux, QEMU_BUILD_BUG_ON in QEMU.
> >> > You have to stick it in a C file though, so it
> >> > won't be visible in this patch.
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
> 
> -- PMM

For most of virtio neither linux nor QEMU are the master.
syncing them has been done manually in the past.
As we are copying other headers from Linux anyway,
I think it would be better for everyone if we make
the Linux headers the master for QEMU going forward.

-- 
MST
