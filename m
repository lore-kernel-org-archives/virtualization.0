From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: vgacon disable again
Date: Wed, 14 Feb 2007 09:07:42 +0100
Message-ID: <45D2C34E.60806@suse.de>
References: <45D198CA.7050306@suse.de> <45D19E95.7030501@suse.de>
	<45D233A9.7030802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D233A9.7030802@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Gerd Hoffmann wrote:
>> Oh, and it obsoletes vgacon-fix-zero-size.patch btw ...
>>   =

> =

> Well, I think the zero-size allocation oops is a bug anyway.  But is it
> really necessary to disable VGA beyond that?

Yes, it is.  Otherwise it oopses as soon as something is printed on
/dev/tty<any>.  Quite early at boot with "console=3Dtty1", otherwise as
soon as /sbin/getty starts on /dev/tty1.  Oh, and the reason is it
thinks it has an EGA card with 0 lines and 0 columns because we never
ran the real-mode boot code and thus SCREEN_INFO isn't initialized.  The
0x0 screen probably leads to the zero-sized buffer you are catching in
that patch.

cheers,

  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
