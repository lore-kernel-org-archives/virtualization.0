From: "Alexey Eremenko" <al4321@gmail.com>
Subject: VMI kernel logging needs to be fixed
Date: Sat, 8 Sep 2007 03:49:29 +0300
Message-ID: <7fac565a0709071749s53b18147se35f8c4e1338fac5@mail.gmail.com>
References: <7fac565a0709071747q3f7edddam602f1cfea94df161@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7fac565a0709071747q3f7edddam602f1cfea94df161@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

---------- Forwarded message ----------
From: Alexey Eremenko <al4321@gmail.com>
Date: Sep 8, 2007 3:47 AM
Subject: VMI kernel logging needs to be fixed
To: virtualization-list@linux-foundation.org


hi kernel devs !

kernel logging (dmesg) produced by VMI are not up to the standards.
Currently, booting VMI-capable kernel produces the following in dmesg:

"Booting paravirtualized kernel on vmi"
-or-
"Booting paravirtualized kernel on bare hardware"

This must be changed to:
"VMI: Booting paravirtualized kernel on vmi"
"VMI: Booting paravirtualized kernel on bare hardware"

-- 
-Alexey Eremenko "Technologov"
