From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC/PATCH 01/15] preparation: provide hook to enable pgstes
	in	user pagetable
Date: Thu, 20 Mar 2008 10:28:38 -0700
Message-ID: <47E29EC6.5050403__42651.6075422571$1206034592$gmane$org@goop.org>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030278.6690.52.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206030278.6690.52.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, hollisb@us.ibm.com, arnd@arndb.de, borntraeger@de.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> +struct mm_struct *dup_mm(struct task_struct *tsk);
>   

No prototypes in .c files.  Put this in an appropriate header.

    J
