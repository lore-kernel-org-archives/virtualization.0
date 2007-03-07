From: Zachary Amsden <zach@vmware.com>
Subject: Re: vdso relocation
Date: Wed, 07 Mar 2007 13:59:21 -0800
Message-ID: <45EF35B9.4050006@vmware.com>
References: <45EF1381.60501@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45EF1381.60501@goop.org>
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
> Are you working on cleaning up the patch?  Do you think it will have any
> conflict with the Xen series?
>
> If all goes well, I'm planning on doing another patch post later today,
> and wondering if it can/should incorporate the vdso reloc changes, or if
> you can just post it as a separate change.
>   =


Probably leave out the vdso reloc changes for now ... they can always be =

added back if somehow mine goes into the weeds, but I'm hopeful to have =

a vdso relocation that works for all cases without the extra build =

complexity.

Zach
