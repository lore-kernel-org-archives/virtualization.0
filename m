From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Oops
Date: Tue, 09 Jan 2007 14:46:56 -0800
Message-ID: <45A41B60.3070500@goop.org>
References: <45A399D7.3090205@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A399D7.3090205@suse.de>
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
>   Hi,
>
> paravirt kernel doesn't boot as xen guest for me, see attachment.
>   =


Hm, I just booted a pae kernel from the current paravirt repo and got it
to usermode.  What's your .config?  Also, what line is getting the fault?

    J
