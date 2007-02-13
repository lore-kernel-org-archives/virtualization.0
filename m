From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: vgacon disable again
Date: Tue, 13 Feb 2007 13:54:49 -0800
Message-ID: <45D233A9.7030802@goop.org>
References: <45D198CA.7050306@suse.de> <45D19E95.7030501@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D19E95.7030501@suse.de>
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
> Oh, and it obsoletes vgacon-fix-zero-size.patch btw ...
>   =


Well, I think the zero-size allocation oops is a bug anyway.  But is it
really necessary to disable VGA beyond that?

    J
