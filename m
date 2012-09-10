From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [patch 3/3] xen/privcmd: remove const modifier from
	declaration
Date: Mon, 10 Sep 2012 11:43:19 +0100
Message-ID: <504DC447.9010301__24852.003347087$1347316641$gmane$org@citrix.com>
References: <20120908095808.GC608@elgon.mountain>
	<504DC8FE020000780009A190@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <504DC8FE020000780009A190@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andres Lagar-Cavilla <andreslc@gridcentric.ca>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/09/12 10:03, Jan Beulich wrote:
>>>> On 08.09.12 at 11:58, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> When we use this pointer, we cast away the const modifier and modify the
>> data.  I think it was an accident to declare it as const.
> 
> NAK - the const is very valid here, as the v2 interface (as opposed
> to the v1 one) does _not_ modify this array (or if it does, it's a
> bug). This is a guarantee made to user mode, so it should also be
> expressed that way in the interface.
> 
> But of course the cast used before this patch isn't right either, as
> it indeed inappropriately discards the qualifier. Afaiu this was done
> to simplify the internal workings of the code, but I don't think it's
> desirable to sacrifice type safety for implementation simplicity.

m.arr here isn't const as m is really the V1 structure where m.arr is
non-const.

David
