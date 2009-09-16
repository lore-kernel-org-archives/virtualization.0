From: Avi Kivity <avi@redhat.com>
Subject: Re: vhost-net todo list
Date: Wed, 16 Sep 2009 20:13:03 +0300
Message-ID: <4AB11C9F.8020001__17888.8036557057$1253121274$gmane$org@redhat.com>
References: <20090916100438.GA30036@redhat.com>
	<200909161708.46412.arnd@arndb.de>
	<20090916151922.GD5513@redhat.com>
	<200909161727.26153.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200909161727.26153.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, anthony@codemonkey.ws, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/16/2009 06:27 PM, Arnd Bergmann wrote:
> That scenario is probably not so relevant for KVM, unless you
> consider the guest taking over the qemu host process a valid
> security threat.
>    

It is.  We address it by using SCM_RIGHTS for all sensitive operations 
and selinuxing qemu as tightly as possible.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
