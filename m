From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Oops
Date: Wed, 10 Jan 2007 12:07:34 -0800
Message-ID: <45A54786.5050300@goop.org>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A4E4A0.5060800@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A4E4A0.5060800@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Gerd Hoffmann wrote:
>   =

>> OK, now I'm back to the old buggy state where the ttylinux rootfs fails
>> to boot up due to init being killed instantly or something like that ...
>>     =

>
> That was something completely different.  Machine booted up just fine,
> but without any output.  Due to initialization in link order and xen/
> coming after serial/ in drivers/ the serial console becomes default when
> enabled.  Ouch.  Move it up.
>   =


Erk.  I hate these link-order dependencies.

    J
