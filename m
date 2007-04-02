From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 02 Apr 2007 13:56:50 -0700
Message-ID: <46116E12.5070206@goop.org>
References: <4611652F.700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965851AbXDBU5L@vger.kernel.org>
In-Reply-To: <4611652F.700@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> On the subject of virtualization; there are a number of devices which
> keep being invented and reinvented by just about every virtualization
> vendor for no really good reason.
>
> I personally recently pointed out that a proper virtualization
> solution should handle entropy collection at the lowest level (where
> the physical hardware drivers are) and present a hw_rng interface to
> the guests. Unfortunately, none of the hardware-based hw_rng
> interfaces is sane enough to do that with, which calls for a virtual
> driver.
>
> It would be nice if there was one, and not a dozen, such drivers.
>
> I would therefore like to propose that the Linux Foundation register a
> PCI ID for use by LANANA ($3000/year), and we set up a LANANA registry
> for these device IDs, together with a description of the device
> interface each of them expect.  Similarly, a Subsystem ID registry can
> be used (for virtualization vendors which don't have their own VID
> already) to distinguish different implementations.
>
> Obviously, anyone who adheres to the published interface can use one
> of these VID:DIDs -- as far as I'm concerned, even hardware vendors;
> we'll use the SID to distinguish between implementations. 

How would that work in the case where virtualized guests don't have a
visible PCI bus, and the virtual environment doesn't pretend to emulate
a PCI bus?

    J
