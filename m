From: Hannes Reinecke <hare@suse.de>
Subject: Re: sometimes ping fails when enable stp
Date: Fri, 11 Apr 2014 09:53:47 +0200
Message-ID: <53479F8B.9020002@suse.de>
References: <5590ca8b.f19f.1454fb2f747.Coremail.kernelluck@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5590ca8b.f19f.1454fb2f747.Coremail.kernelluck@163.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "longguang.yue" <kernelluck@163.com>, virtualization <virtualization@lists.linux-foundation.org>, bridge <bridge@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 04/11/2014 09:31 AM, longguang.yue wrote:
> hi,all
> sometimes ping fails when enable stp , why?
>  =

Probably stp initialisation isn't yet finished, and the switch will
block any traffic until that happens.
During that time any traffic will return with -EHOSTUNREACH.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
