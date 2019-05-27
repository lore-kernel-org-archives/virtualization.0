From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: PROBLEM: VirtIO DRM driver crashes when setting specific 16.16
	fixed-point property values
Date: Mon, 27 May 2019 08:47:43 +0200
Message-ID: <20190527064743.kooeycqfj7t22iwt__3700.9395704203$1558939691$gmane$org@sirius.home.kraxel.org>
References: <CAOoxD-tWknshQLXFzyv2t1CVhfK0SCNec=6MVij9q6kQAVzY=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAOoxD-tWknshQLXFzyv2t1CVhfK0SCNec=6MVij9q6kQAVzY=g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tyler Slabinski <tslabinski@slabity.net>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 24, 2019 at 02:46:50PM -0400, Tyler Slabinski wrote:
> VirtIO DRM driver crashes when setting specific 16.16 fixed-point
> property values
> 
> When running a virtual machine with a VirtIO GPU, it's possible to
> crash the entire VM by setting the value of a 16.16 fixed-point
> property to any value below 65536 (1.0 in 16.16 format or 0x00010000).
> As a specific example, setting the SRC_W property on a plane DRM
> object to a value of 30000 will cause the VM to hard-shutdown.

Do you have a qemu stacktrace?

thanks,
  Gerd
