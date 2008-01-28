From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/2] virtio reset support
Date: Mon, 28 Jan 2008 17:48:34 +0200
Message-ID: <479DF952.9040201__21337.424850981$1201535473$gmane$org@qumranet.com>
References: <200801240116.26160.rusty@rustcorp.com.au>
	<200801240118.09032.rusty@rustcorp.com.au>
	<479C8599.60007@qumranet.com> <479DF787.2020100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479DF787.2020100@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Dor Laor <dor.laor@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>
> PCI-e has a common reset concept (warm and cold).  I've been looking 
> around and I can't seem to find any common reset mechanism for PCI.  
> Is FLR something that is per-device or a standard PCI mechanism?  If 
> it's the former, than we've basically implemented FLR using this bit 
> in the config space.
>

I believe it is a standard mechanism, albeit new, so perhaps many 
devices don't implement it.

-- 
error compiling committee.c: too many arguments to function
