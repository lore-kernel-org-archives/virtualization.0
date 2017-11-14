From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: add create_handle support.
Date: Tue, 14 Nov 2017 11:11:49 +0100
Message-ID: <20171114101149.ms5ck33kzxymg7nu__46403.4561221071$1510654325$gmane$org@sirius.home.kraxel.org>
References: <20171108125659.oyjzylx26zmz7753@phenom.ffwll.local>
	<20171108184209.46211-1-ytht.net@gmail.com>
	<CALqoU4y=w8m5g_vCHTRmiBYg1g8W1xcJ5qih2pj+HQeQ2tNo2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALqoU4y=w8m5g_vCHTRmiBYg1g8W1xcJ5qih2pj+HQeQ2tNo2Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lepton <ytht.net@gmail.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 13, 2017 at 02:19:29PM -0800, lepton wrote:
> Ping.
> 
> On Wed, Nov 8, 2017 at 10:42 AM, Lepton Wu <ytht.net@gmail.com> wrote:
> > Add create_handle support to virtio fb. Without this, screenshot tool
> > in chromium OS can't work.

Already queued up in drm-misc-next (the cirrus patch too).

cheers,
  Gerd
