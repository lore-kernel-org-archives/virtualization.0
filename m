From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: arm64 kernel crash in bochs_get_edid_block() with QEMU '-device
 VGA'
Date: Wed, 25 Mar 2020 10:59:38 +0100
Message-ID: <20200325095938.vn4v7bdk6pgmotxg@sirius.home.kraxel.org>
References: <CADLDEKugE-Y9rMumiCDJDW_FvGcBaQd3fBv80YeSS0=udnkMAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADLDEKugE-Y9rMumiCDJDW_FvGcBaQd3fBv80YeSS0=udnkMAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juerg Haefliger <juergh@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Feb 15, 2020 at 01:11:45PM +0100, Juerg Haefliger wrote:
> The QEMU default edid=off results in a kernel crash [1] on arm64 due
> to commit [2]. To reproduce:

Should be fixed in qemu 5.0-rc0

cheers,
  Gerd
