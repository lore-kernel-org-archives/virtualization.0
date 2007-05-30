From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 17:01:22 +0200
Message-ID: <200705301701.23386.ak@suse.de>
References: <465D8F03.7000201@us.ibm.com> <465D8FF5.6040804@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <465D8FF5.6040804-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 30 May 2007 16:53:41 Anthony Liguori wrote:
> Subject: [PATCH][PARAVIRT] Eliminate unnecessary CR3 read in TLB flush
> =

> This patch eliminates the CR3 read (which would cause a VM exit) in the T=
LB
> flush path. =A0The patch is based on Ingo Molnar's paravirt series.
> =


This change could be just done generically for the native architecture, cou=
ldn't =

it?

-Andi

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
