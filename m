From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Thu, 1 Dec 2011 11:09:21 +0200
Message-ID: <20111201090920.GA8231@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<20111129131110.GC19157@redhat.com>
	<CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
	<20111129151958.GA31789@redhat.com>
	<CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
	<20111130145004.GD21413@redhat.com>
	<CAK=WgbY59n9N_-2_TZ9wNBNcTMV1DCrz65e-Ae=xamcg6A0dOA@mail.gmail.com>
	<20111130231306.GD30031@redhat.com>
	<CAK=Wgbb5M62LgXY-sn7R6YautHxwqyDbPTeXYJxgmrS9fPXR9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK=Wgbb5M62LgXY-sn7R6YautHxwqyDbPTeXYJxgmrS9fPXR9A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>, dhowells@redhat.com, paulmck@linux.vnet.ibm.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 01, 2011 at 08:14:26AM +0200, Ohad Ben-Cohen wrote:
> On Thu, Dec 1, 2011 at 1:13 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > For x86, stores into memory are ordered. So I think that yes, smp_XXX
> > can be selected at compile time.
> 
> But then you can't use the same kernel image for both scenarios.

I was talking about virtio-pci. That always allocates the ring
in the normal memory.

> It won't take long until people will use virtio on ARM for both
> virtualization and for talking to devices, and having to rebuild the
> kernel for different use cases is nasty.

Yes, I understand that it's nasty.

> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
