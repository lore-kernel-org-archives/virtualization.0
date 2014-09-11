From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec
	include file
Date: Thu, 11 Sep 2014 17:43:49 +0200
Message-ID: <1410450229.8604.16.camel@nilsson.home.kraxel.org>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
	<CAFEAcA_q7XPr7n=BpkR7oo5GRereO_NJQ5jC3Y2=8ez2xTQLXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA_q7XPr7n=BpkR7oo5GRereO_NJQ5jC3Y2=8ez2xTQLXQ@mail.gmail.com>
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

On Do, 2014-09-11 at 16:20 +0100, Peter Maydell wrote:
> On 11 September 2014 16:09, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > This patch adds the header file with structs and defines for
> > the virtio based gpu device.  Covers 2d operations only.
> 
> Please don't cc subscriber only mailing lists
> (virtio-dev@lists.oasis-open.org) on posts to qemu-devel;
> it just means everybody responding gets mailer bounce
> junkmail.

I don't feel like splitting the discussion though.  Suggestions how to
deal with that?  I think I've seen most active virtio-dev folks on the
virtualization list too, is it ok to just drop virtio-dev for the next
round and hope that folks see it via virtualization list?

cheers,
  Gerd
